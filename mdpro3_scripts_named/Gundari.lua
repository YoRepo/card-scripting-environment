--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Gundari  (ID: 38975369)
-- Type: Monster / Effect / Spirit
-- Attribute: FIRE
-- Race: Pyro
-- Level: 4
-- ATK 1000 | DEF 200
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card cannot be Special Summoned.
-- This card returns to its owner's hand during the End Phase of the turn it is Normal Summoned or
-- flipped face-up.
-- If this card battles a Synchro Monster, return both monsters to their owners' hands at the start of
-- the Damage Step (without damage calculation).
--[[ __CARD_HEADER_END__ ]]

--軍荼利
function c38975369.initial_effect(c)
	--spirit
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--return to hand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(38975369,0))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BATTLE_START)
	e4:SetCondition(c38975369.thcon)
	e4:SetTarget(c38975369.thtg)
	e4:SetOperation(c38975369.thop)
	c:RegisterEffect(e4)
end
function c38975369.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsFaceup() and bc:IsType(TYPE_SYNCHRO)
end
function c38975369.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Group.FromCards(Duel.GetAttacker(),Duel.GetAttackTarget())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c38975369.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	local c=Duel.GetAttacker()
	if c:IsRelateToBattle() then g:AddCard(c) end
	c=Duel.GetAttackTarget()
	if c~=nil and c:IsRelateToBattle() then g:AddCard(c) end
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
end
