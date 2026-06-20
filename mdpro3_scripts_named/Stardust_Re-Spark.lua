--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 立于星坠之地的闪珖  (ID: 20590784)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 163
--
-- Effect Text:
-- 「立于星坠之地的闪珖」在1回合只能发动1张。
-- ①：特殊召唤的对方怪兽的直接攻击宣言时，那只怪兽的攻击力是自己基本分以上的场合才能发动。那次攻击无效，自己从卡组抽1张。那之后，可以从自己的额外卡组·墓地选1只「星尘」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--星墜つる地に立つ閃珖
function c20590784.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCountLimit(1,20590784+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c20590784.condition)
	e1:SetTarget(c20590784.target)
	e1:SetOperation(c20590784.activate)
	c:RegisterEffect(e1)
end
function c20590784.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c20590784.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local at=Duel.GetAttacker()
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and at:IsOnField() and at:GetAttack()>=Duel.GetLP(tp)
		and at:IsSummonType(SUMMON_TYPE_SPECIAL) end
end
function c20590784.filter(c,e,tp)
	return c:IsSetCard(0xa3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and (c:IsLocation(LOCATION_GRAVE) and Duel.GetMZoneCount(tp)>0
			or c:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0)
end
function c20590784.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() and Duel.Draw(tp,1,REASON_EFFECT)~=0 then
		local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c20590784.filter),tp,LOCATION_GRAVE+LOCATION_EXTRA,0,nil,e,tp)
		if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(20590784,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=g:Select(tp,1,1,nil)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
