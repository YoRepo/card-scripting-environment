--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 永火野猫  (ID: 74148483)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 1400 | DEF 0
-- Setcode: 11
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：这张卡可以把手卡1只其他的「永火」怪兽送去墓地，从手卡特殊召唤。
-- ②：自己手卡是0张的场合，把自己墓地1只「永火」怪兽除外才能发动。这张卡的等级直到回合结束时上升或者下降1星。
--[[ __CARD_HEADER_END__ ]]

--インフェルニティ・ワイルドキャット
function c74148483.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,74148483+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c74148483.spcon)
	e1:SetTarget(c74148483.sptg)
	e1:SetOperation(c74148483.spop)
	c:RegisterEffect(e1)
	--lv
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(74148483,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,74148484)
	e2:SetCondition(c74148483.lvcon)
	e2:SetCost(c74148483.lvcost)
	e2:SetTarget(c74148483.lvtg)
	e2:SetOperation(c74148483.lvop)
	c:RegisterEffect(e2)
end
function c74148483.spfilter(c)
	return c:IsSetCard(0xb) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c74148483.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
	return Duel.IsExistingMatchingCard(c74148483.spfilter,tp,LOCATION_HAND,0,1,c)
end
function c74148483.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c74148483.spfilter,tp,LOCATION_HAND,0,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c74148483.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_SPSUMMON)
end
function c74148483.lvcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
end
function c74148483.costfilter(c)
	return c:IsSetCard(0xb) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c74148483.lvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c74148483.costfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c74148483.costfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c74148483.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsLevelAbove(1) end
end
function c74148483.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local opt=0
		if c:IsLevel(1) then
			opt=Duel.SelectOption(tp,aux.Stringid(74148483,1))
		else
			opt=Duel.SelectOption(tp,aux.Stringid(74148483,1),aux.Stringid(74148483,2))
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		if opt==0 then
			e1:SetValue(1)
		else
			e1:SetValue(-1)
		end
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
