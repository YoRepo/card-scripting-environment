--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Electric Snake  (ID: 11324436)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level: 3
-- ATK 800 | DEF 900
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is discarded from your hand to the Graveyard by an effect of a card controlled by
-- your opponent, draw 2 cards from your Deck.
--[[ __CARD_HEADER_END__ ]]

--エレクトリック・スネーク
function c11324436.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11324436,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c11324436.drcon)
	e1:SetTarget(c11324436.drtg)
	e1:SetOperation(c11324436.drop)
	c:RegisterEffect(e1)
end
function c11324436.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND) and bit.band(r,0x4040)==0x4040 and rp==1-tp
end
function c11324436.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c11324436.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
