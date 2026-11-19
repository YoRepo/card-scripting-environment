--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-19T23:32:31
-- Source DB: test-release.cdb
-- Card: Blue-Eyes Chaos MAXIMUM Dragon  (ID: 101308027)
-- Type: Monster / Effect / Ritual
-- Attribute: DARK
-- Race: Dragon
-- Level: 8
-- ATK 4000 | DEF 0
-- Setcode: 0xdd, 0xcf
-- Scope: OCG
--
-- Effect Text:
-- You can Ritual Summon this card with "Chaos Form". Must be Ritual Summoned. You can banish this card
-- from your hand; add 1 "Neo Chaos Form" from your Deck, GY, or banishment to your hand. You can only
-- use this effect of "Blue-Eyes Chaos MAXIMUM Dragon" once per turn. If your monster that mentions
-- "Endless Darkness" attacks a Defense Position monster, inflict piercing battle damage to your
-- opponent. Any battle damage your opponent takes from battles involving this card is doubled.
--[[ __CARD_HEADER_END__ ]]

--ブルーアイズ・カオス・MAXIMUM・ドラゴン
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,21082832,101308049,101308050)
	c:EnableReviveLimit()
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(aux.ritlimit)
	c:RegisterEffect(e0)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCost(s.thcost)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PIERCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(s.ptarget)
	c:RegisterEffect(e2)
	--double damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CHANGE_INVOLVING_BATTLE_DAMAGE)
	e3:SetValue(aux.ChangeBattleDamage(1,DOUBLE_DAMAGE))
	c:RegisterEffect(e3)
end
function s.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToRemoveAsCost() end
	Duel.Remove(c,POS_FACEUP,REASON_COST)
end
function s.thfilter(c)
	return c:IsCode(101308050) and c:IsAbleToHand() and c:IsFaceupEx()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
	if g then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function s.ptarget(e,c)
	return aux.IsCodeListed(c,101308049)
end
