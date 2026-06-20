--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 黑羽-毒风之西蒙  (ID: 81470373)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level 6
-- ATK 1600 | DEF 2000
-- Setcode: 51
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：自己场上没有怪兽存在的场合，从手卡把这张卡以外的1只「黑羽」怪兽除外才能发动。从卡组选1张「黑旋风」在自己的魔法与陷阱区域表侧表示放置。那之后，手卡的这张卡不用解放作召唤或送去墓地。这个效果放置的
-- 「黑旋风」在结束阶段送去墓地，自己受到1000伤害。这个效果的发动后，直到回合结束时自己不是暗属性怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--BF－毒風のシムーン
local s,id,o=GetID()
function s.initial_effect(c)
	--search and normal summon / gy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SUMMON+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.sumcon)
	e1:SetCost(s.sumcost)
	e1:SetTarget(s.sumtg)
	e1:SetOperation(s.sumop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(s.ntcon)
	e2:SetValue(SUMMON_TYPE_NORMAL)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
function s.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and Duel.CheckTribute(c,0)
end
function s.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function s.cfilter(c)
	return c:IsSetCard(0x33) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function s.sumcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_HAND,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,s.cfilter,tp,LOCATION_HAND,0,1,1,c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function s.acfilter(c,tp)
	return c:IsCode(91351370) and not c:IsForbidden() and c:CheckUniqueOnField(tp)
end
function s.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0
			or not Duel.IsExistingMatchingCard(s.acfilter,tp,LOCATION_DECK,0,1,nil,tp) then return false end
		return e:GetHandler():IsSummonable(true,e:GetLabelObject()) or e:GetHandler():IsAbleToGrave()
	end
end
function s.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(s.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local tc=Duel.SelectMatchingCard(tp,s.acfilter,tp,LOCATION_DECK,0,1,1,nil,tp):GetFirst()
	if tc and Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetRange(LOCATION_SZONE)
		e1:SetCountLimit(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetOperation(s.tgop)
		tc:RegisterEffect(e1)
		if not c:IsRelateToEffect(e) then return end
		local se=e:GetLabelObject()
		if c:IsSummonable(true,se)
			and (not c:IsAbleToGrave() or Duel.SelectOption(tp,1151,1191)==0) then
			Duel.BreakEffect()
			Duel.Summon(tp,c,true,se)
		else
			Duel.BreakEffect()
			Duel.SendtoGrave(c,REASON_EFFECT)
		end
	end
end
function s.splimit(e,c)
	return not c:IsAttribute(ATTRIBUTE_DARK) and c:IsLocation(LOCATION_EXTRA)
end
function s.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,id)
	local c=e:GetHandler()
	if Duel.SendtoGrave(c,REASON_EFFECT)~=0 then
		Duel.Damage(tp,1000,REASON_EFFECT)
	end
end
