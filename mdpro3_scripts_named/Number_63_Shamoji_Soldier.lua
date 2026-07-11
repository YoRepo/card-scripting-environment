--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Number 63: Shamoji Soldier  (ID: 89642993)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Fairy
-- Rank: 1
-- ATK 0 | DEF 2000
-- Setcode: 0x48
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 1 monsters
-- You can only use the effect of "Number 63: Shamoji Soldier" once per turn.
-- You can detach 1 Xyz Material from this card, then activate 1 of these effects;
-- ● At the start of your opponent's next Standby Phase, each player draws 1 card.
-- ● Each player gains 1000 Life Points.
--[[ __CARD_HEADER_END__ ]]

--No.63 おしゃもじソルジャー
function c89642993.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,1,2)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89642993,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,89642993)
	e1:SetCost(c89642993.efcost)
	e1:SetTarget(c89642993.eftg)
	e1:SetOperation(c89642993.efop)
	c:RegisterEffect(e1)
end
aux.xyz_number[89642993]=63
function c89642993.efcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c89642993.eftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local op=Duel.SelectOption(tp,aux.Stringid(89642993,1),aux.Stringid(89642993,2))
	e:SetLabel(op)
	if op==0 then
		e:SetCategory(CATEGORY_DRAW)
	else
		e:SetCategory(CATEGORY_RECOVER)
	end
end
function c89642993.efop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE_START+PHASE_STANDBY)
		e1:SetCountLimit(1)
		e1:SetCondition(c89642993.drcon)
		e1:SetOperation(c89642993.drop)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		Duel.RegisterEffect(e1,tp)
	else
		Duel.Recover(tp,1000,REASON_EFFECT)
		Duel.Recover(1-tp,1000,REASON_EFFECT)
	end
end
function c89642993.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c89642993.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,89642993)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Draw(1-tp,1,REASON_EFFECT)
end
