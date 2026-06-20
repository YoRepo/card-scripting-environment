--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 死亡反击  (ID: 39131963)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 进行直接攻击并对玩家造成战斗伤害的怪兽被破坏。
--[[ __CARD_HEADER_END__ ]]

--デスカウンター
function c39131963.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(39131963,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c39131963.condition)
	e2:SetTarget(c39131963.target)
	e2:SetOperation(c39131963.operation)
	c:RegisterEffect(e2)
end
function c39131963.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil
end
function c39131963.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
end
function c39131963.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
