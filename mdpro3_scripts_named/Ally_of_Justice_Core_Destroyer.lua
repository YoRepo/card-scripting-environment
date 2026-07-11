--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Ally of Justice Core Destroyer  (ID: 36629203)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 3
-- ATK 1200 | DEF 200
-- Setcode: 0x1
-- Scope: OCG / TCG
--
-- Effect Text:
-- At the start of the Damage Step, if this card battles a LIGHT monster: Destroy that monster.
--[[ __CARD_HEADER_END__ ]]

--A・O・J コアデストロイ
function c36629203.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(36629203,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetTarget(c36629203.destg)
	e1:SetOperation(c36629203.desop)
	c:RegisterEffect(e1)
end
function c36629203.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if tc==c then tc=Duel.GetAttackTarget() end
	if chk==0 then return tc and tc:IsFaceup() and tc:IsAttribute(ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c36629203.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if tc==c then tc=Duel.GetAttackTarget() end
	if tc:IsRelateToBattle() then Duel.Destroy(tc,REASON_EFFECT) end
end
