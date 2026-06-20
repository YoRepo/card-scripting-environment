--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 落穴  (ID: 4206964)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 76
--
-- Effect Text:
-- ①：对方对攻击力1000以上的怪兽的召唤·反转召唤成功时，以那1只怪兽为对象才能发动。那只攻击力1000以上的怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--落とし穴
function c4206964.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c4206964.target)
	e1:SetOperation(c4206964.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c4206964.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if not eg then return false end
	local tc=eg:GetFirst()
	if chkc then return chkc==tc end
	if chk==0 then return ep~=tp and tc:IsFaceup() and tc:GetAttack()>=1000 and tc:IsOnField() and tc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c4206964.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:GetAttack()>=1000 then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
