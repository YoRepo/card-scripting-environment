--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Battlin' Boxer Rabbit Puncher  (ID: 61679541)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level: 3
-- ATK 800 | DEF 1000
-- Setcode: 0x1084
-- Scope: OCG / TCG
--
-- Effect Text:
-- At the start of the Damage Step, if this card attacks a Defense Position monster: Destroy that
-- monster.
--[[ __CARD_HEADER_END__ ]]

--BK ラビット・パンチャー
function c61679541.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(61679541,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetTarget(c61679541.targ)
	e1:SetOperation(c61679541.op)
	c:RegisterEffect(e1)
end
function c61679541.targ(e,tp,eg,ep,ev,re,r,rp,chk)
	local d=Duel.GetAttackTarget()
	if chk==0 then return Duel.GetAttacker()==e:GetHandler()
		and d~=nil and d:IsDefensePos() and d:IsRelateToBattle() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,d,1,0,0)
end
function c61679541.op(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d~=nil and d:IsRelateToBattle() and d:IsDefensePos() then
		Duel.Destroy(d,REASON_EFFECT)
	end
end
