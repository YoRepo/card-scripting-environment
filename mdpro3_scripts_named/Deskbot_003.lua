--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 文具电子人003  (ID: 75944053)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 3
-- ATK 500 | DEF 500
-- Setcode: 171
--
-- Effect Text:
-- ①：这张卡召唤成功时才能发动。从卡组把「文具电子人003」以外的1只「文具电子人」怪兽特殊召唤。
-- ②：1回合1次，以自己场上1只「文具电子人」怪兽为对象才能发动。那只怪兽的攻击力·守备力直到回合结束时上升自己场上的「文具电子人」卡数量×500。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--ブンボーグ003
function c75944053.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c75944053.sptg)
	e1:SetOperation(c75944053.spop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCountLimit(1)
	e2:SetCondition(aux.dscon)
	e2:SetTarget(c75944053.target)
	e2:SetOperation(c75944053.operation)
	c:RegisterEffect(e2)
end
function c75944053.spfilter(c,e,tp)
	return c:IsSetCard(0xab) and not c:IsCode(75944053) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75944053.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c75944053.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c75944053.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c75944053.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c75944053.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xab)
end
function c75944053.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c75944053.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75944053.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c75944053.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c75944053.operation(e,tp,eg,ep,ev,re,r,rp)
	local val=Duel.GetMatchingGroupCount(c75944053.filter,tp,LOCATION_ONFIELD,0,nil)*500
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(val)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
	end
end
