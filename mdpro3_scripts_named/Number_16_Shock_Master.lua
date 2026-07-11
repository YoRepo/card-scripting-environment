--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Number 16: Shock Master  (ID: 54719828)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Fairy
-- Rank: 4
-- ATK 2300 | DEF 1600
-- Setcode: 0x48
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Level 4 monsters
-- Once per turn: You can detach 1 Xyz Material from this card to declare 1 card type (Monster, Spell,
-- or Trap); that type of card (if Spell or Trap) cannot be activated, or (if Monster) cannot activate
-- its effects, until the end of your opponent's next turn.
--[[ __CARD_HEADER_END__ ]]

--No.16 色の支配者ショック・ルーラー
function c54719828.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,3)
	c:EnableReviveLimit()
	--act limit
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54719828,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c54719828.cost)
	e1:SetTarget(c54719828.target)
	e1:SetOperation(c54719828.operation)
	c:RegisterEffect(e1)
end
aux.xyz_number[54719828]=16
function c54719828.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c54719828.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	e:SetLabel(Duel.AnnounceType(tp))
end
function c54719828.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,1)
	if e:GetLabel()==0 then
		e1:SetDescription(aux.Stringid(54719828,2))
		e1:SetValue(c54719828.aclimit1)
	elseif e:GetLabel()==1 then
		e1:SetDescription(aux.Stringid(54719828,3))
		e1:SetValue(c54719828.aclimit2)
	else
		e1:SetDescription(aux.Stringid(54719828,4))
		e1:SetValue(c54719828.aclimit3)
	end
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,1)
	Duel.RegisterEffect(e1,tp)
end
function c54719828.aclimit1(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER)
end
function c54719828.aclimit2(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL)
end
function c54719828.aclimit3(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_TRAP)
end
