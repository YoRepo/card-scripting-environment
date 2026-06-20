--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 同胞的牵绊  (ID: 40450317)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这张卡发动的回合，自己不能进行战斗阶段。
-- ①：支付2000基本分，以自己场上1只4星以下的怪兽为对象才能发动。和那只怪兽是卡名不同并是种族·属性·等级相同的2只怪兽从卡组特殊召唤（同名卡最多1张）。这张卡的发动后，直到回合结束时自己不能把怪兽
-- 特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--同胞の絆
function c40450317.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c40450317.cost)
	e1:SetTarget(c40450317.target)
	e1:SetOperation(c40450317.activate)
	c:RegisterEffect(e1)
end
function c40450317.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000) and Duel.GetActivityCount(tp,ACTIVITY_BATTLE_PHASE)==0 end
	Duel.PayLPCost(tp,2000)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c40450317.filter(c,e,tp)
	if c:IsFacedown() or not c:IsLevelBelow(4) then return false end
	local g=Duel.GetMatchingGroup(c40450317.filter2,tp,LOCATION_DECK,0,nil,e,tp,c)
	return g:GetClassCount(Card.GetCode)>1
end
function c40450317.filter2(c,e,tp,tc)
	return c:IsLevel(tc:GetLevel()) and c:IsRace(tc:GetRace()) and c:IsAttribute(tc:GetAttribute())
		and not c:IsCode(tc:GetCode()) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c40450317.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c40450317.filter(chkc,e,tp) end
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingTarget(c40450317.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c40450317.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c40450317.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.GetMatchingGroup(c40450317.filter2,tp,LOCATION_DECK,0,nil,e,tp,tc)
	if not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and ft>1 and g:GetClassCount(Card.GetCode)>1 and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g1=g:SelectSubGroup(tp,aux.dncheck,false,2,2)
		Duel.SpecialSummon(g1,0,tp,tp,false,false,POS_FACEUP)
	end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetTargetRange(1,0)
		Duel.RegisterEffect(e1,tp)
	end
end
