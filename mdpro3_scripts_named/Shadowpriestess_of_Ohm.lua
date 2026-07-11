--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Shadowpriestess of Ohm  (ID: 27869883)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 4
-- ATK 1700 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Tribute 1 face-up DARK monster you control to inflict 800 damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--プリーステス・オーム
function c27869883.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27869883,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c27869883.damcost)
	e1:SetTarget(c27869883.damtg)
	e1:SetOperation(c27869883.damop)
	c:RegisterEffect(e1)
end
function c27869883.cfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DARK)
end
function c27869883.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c27869883.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c27869883.cfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c27869883.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,800)
end
function c27869883.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
