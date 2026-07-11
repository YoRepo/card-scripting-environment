--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Witch Doctor of Sparta  (ID: 30525991)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Spellcaster
-- Level: 4
-- ATK 400 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Inflict 500 damage to your opponent each time a monster(s) is Special Summoned from either player's
-- Deck.
--[[ __CARD_HEADER_END__ ]]

--スパルタクァの呪術師
function c30525991.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30525991,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c30525991.con)
	e1:SetTarget(c30525991.tg)
	e1:SetOperation(c30525991.op)
	c:RegisterEffect(e1)
end
function c30525991.cfilter(c)
	return c:IsPreviousLocation(LOCATION_DECK)
end
function c30525991.con(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c30525991.cfilter,1,nil)
end
function c30525991.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c30525991.op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
