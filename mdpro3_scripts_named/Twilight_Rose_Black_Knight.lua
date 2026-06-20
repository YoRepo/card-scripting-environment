--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 夜蔷薇之黑骑士  (ID: 92595825)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Plant
-- Level 3
-- ATK 1000 | DEF 1000
-- Setcode: 291
--
-- Effect Text:
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：这张卡召唤·特殊召唤的场合才能发动。从自己墓地把1只「黑蔷薇龙」或者4星以下的植物族怪兽特殊召唤。这个效果特殊召唤的怪兽的效果无效化。
-- ②：只要自己场上有同调怪兽存在，自己场上的植物族怪兽的攻击力上升1000。
-- ③：以自己场上1只其他的植物族怪兽为对象才能发动。那只怪兽的等级上升或下降1星。
--[[ __CARD_HEADER_END__ ]]

--夜薔薇の黒騎士
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,73580471)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetCondition(s.atkcon)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_PLANT))
	e3:SetValue(1000)
	c:RegisterEffect(e3)
	--level change
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,1))
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,id+o)
	e4:SetTarget(s.lvtg)
	e4:SetOperation(s.lvop)
	c:RegisterEffect(e4)
end
function s.spfilter(c,e,tp)
	return (c:IsCode(73580471) or c:IsRace(RACE_PLANT) and c:IsLevelBelow(4)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.spfilter),tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		local tc=g:GetFirst()
		if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetValue(RESET_TURN_SET)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e2)
		end
		Duel.SpecialSummonComplete()
	end
end
function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local p=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(aux.AND(Card.IsFaceup,Card.IsType),p,LOCATION_MZONE,0,1,nil,TYPE_SYNCHRO)
end
function s.lvfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(1) and c:IsRace(RACE_PLANT)
end
function s.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and chkc~=c and s.lvfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.lvfilter,tp,LOCATION_MZONE,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,s.lvfilter,tp,LOCATION_MZONE,0,1,1,c)
end
function s.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsType(TYPE_MONSTER) and tc:IsRelateToChain() then
		local op=0
		if tc:IsLevel(1) then op=1
		else op=aux.SelectFromOptions(tp,
			{true,aux.Stringid(id,2),1},
			{true,aux.Stringid(id,3),-1})
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(op)
		tc:RegisterEffect(e1)
	end
end
