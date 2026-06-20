--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 零-最大  (ID: 30562585)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己手卡是0张的场合，选择自己墓地存在的1只名字带有「永火」的怪兽才能发动。选择的怪兽特殊召唤，持有比特殊召唤的怪兽的攻击力低的攻击力的场上表侧表示存在的怪兽全部破坏。这张卡发动的回合，自己不能进行战
-- 斗阶段。
--[[ __CARD_HEADER_END__ ]]

--ZERO－MAX
function c30562585.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c30562585.condition)
	e1:SetCost(c30562585.cost)
	e1:SetTarget(c30562585.target)
	e1:SetOperation(c30562585.activate)
	c:RegisterEffect(e1)
end
function c30562585.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
end
function c30562585.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCurrentPhase()~=PHASE_MAIN2 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c30562585.filter(c,e,tp)
	return c:IsSetCard(0xb) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c30562585.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c30562585.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c30562585.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c30562585.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	local tc=g:GetFirst()
	local dg=Duel.GetMatchingGroup(c30562585.dfilter,tp,LOCATION_MZONE,LOCATION_MZONE,tc,tc:GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
end
function c30562585.dfilter(c,atk)
	return c:IsFaceup() and c:GetAttack()<atk
end
function c30562585.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
		Duel.BreakEffect()
		local dg=Duel.GetMatchingGroup(c30562585.dfilter,tp,LOCATION_MZONE,LOCATION_MZONE,tc,tc:GetAttack())
		if dg:GetCount()>0 then
			Duel.Destroy(dg,REASON_EFFECT)
		end
	end
end
