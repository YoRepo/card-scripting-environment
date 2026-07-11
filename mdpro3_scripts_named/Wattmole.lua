--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Wattmole  (ID: 32548609)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level: 3
-- ATK 0 | DEF 100
-- Setcode: 0xe
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can make a second attack during each Battle Phase.
-- At the start of the Damage Step, if this card attacks a face-down Defense Position monster: You can
-- destroy that face-down monster.
--[[ __CARD_HEADER_END__ ]]

--エレキンモグラ
function c32548609.initial_effect(c)
	--extra attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(32548609,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetCondition(c32548609.descon)
	e2:SetTarget(c32548609.destg)
	e2:SetOperation(c32548609.desop)
	c:RegisterEffect(e2)
end
function c32548609.descon(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return e:GetHandler()==Duel.GetAttacker() and d and d:IsFacedown() and d:IsDefensePos()
end
function c32548609.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttackTarget():IsRelateToBattle() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,Duel.GetAttackTarget(),1,0,0)
end
function c32548609.desop(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d:IsRelateToBattle() then
		Duel.Destroy(d,REASON_EFFECT)
	end
end
