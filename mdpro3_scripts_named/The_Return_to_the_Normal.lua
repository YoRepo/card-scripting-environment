--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 怪蹴一色  (ID: 56001930)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：只让怪兽1只召唤·特殊召唤时才能发动。持有比那只怪兽低的攻击力的场上的怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--怪蹴一色
function c56001930.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,56001930+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c56001930.condition)
	e1:SetTarget(c56001930.target)
	e1:SetOperation(c56001930.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c56001930.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetCount()==1 and eg:GetFirst():IsFaceup()
end
function c56001930.filter(c,atk)
	return c:IsFaceup() and c:IsAttackBelow(atk-1)
end
function c56001930.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	local atk=tc:GetAttack()
	if chk==0 then return Duel.IsExistingMatchingCard(c56001930.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,atk) end
	tc:CreateEffectRelation(e)
	local g=Duel.GetMatchingGroup(c56001930.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,atk)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c56001930.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(c56001930.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tc:GetAttack())
		if g:GetCount()>0 then
			Duel.Destroy(g,REASON_EFFECT)
		end
	end
end
