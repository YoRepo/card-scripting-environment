--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 联合攻击  (ID: 8964854)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 有同盟怪兽装备的怪兽进行过战斗的战斗阶段时才能发动。选择1只有同盟怪兽装备并进行过战斗的怪兽，把装备的同盟解除。选择的怪兽在这个回合可以再1次攻击。
--[[ __CARD_HEADER_END__ ]]

--コンビネーション・アタック
function c8964854.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c8964854.condition)
	e1:SetTarget(c8964854.target)
	e1:SetOperation(c8964854.operation)
	c:RegisterEffect(e1)
end
c8964854.has_text_type=TYPE_UNION
function c8964854.condition(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE)
end
function c8964854.filter(c,e,tp)
	return c:GetAttackAnnouncedCount()>0 and Duel.IsExistingMatchingCard(c8964854.eqfilter,tp,LOCATION_SZONE,0,1,nil,e,tp,c)
end
function c8964854.eqfilter(c,e,tp,ec)
	local op=c:GetOwner()
	return c:IsHasEffect(EFFECT_UNION_STATUS) and c:GetEquipTarget()==ec
		and Duel.GetLocationCount(op,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,op)
end
function c8964854.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c8964854.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c8964854.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c8964854.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_SZONE)
end
function c8964854.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local op=tc:GetOwner()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and Duel.GetLocationCount(op,LOCATION_MZONE)>0 then
		local g=Duel.GetMatchingGroup(c8964854.eqfilter,tp,LOCATION_SZONE,0,nil,e,tp,tc)
		if Duel.SpecialSummon(g,0,tp,op,false,false,POS_FACEUP)>0 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_EXTRA_ATTACK)
			e1:SetValue(tc:GetAttackAnnouncedCount())
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
		end
	end
end
