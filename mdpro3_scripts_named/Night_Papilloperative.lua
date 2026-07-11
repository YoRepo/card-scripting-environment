--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Night Papilloperative  (ID: 2191144)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Warrior
-- Rank: 4
-- ATK 2600 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Level 4 monsters
-- Once per turn: You can detach 1 Xyz Material from this card; this card gains 300 ATK for each Xyz
-- Material attached to a monster on the field.
--[[ __CARD_HEADER_END__ ]]

--ナイト・バタフライ・アサシン
function c2191144.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,3)
	c:EnableReviveLimit()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2191144,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c2191144.atkcost)
	e1:SetTarget(c2191144.atktg)
	e1:SetOperation(c2191144.atkop)
	c:RegisterEffect(e1)
end
function c2191144.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c2191144.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetOverlayCount(tp,1,1)>1 end
end
function c2191144.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local ct=Duel.GetOverlayCount(tp,1,1)
		if ct>0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(ct*300)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
			c:RegisterEffect(e1)
		end
	end
end
