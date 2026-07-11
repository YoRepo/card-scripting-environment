--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Qliphort Scout  (ID: 65518099)
-- Type: Monster / Normal / Pendulum
-- Attribute: EARTH
-- Race: Machine
-- Level: 5
-- ATK 1000 | DEF 2800
-- Pendulum Scale: L9 / R9
-- Setcode: 0xaa
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 9
-- [ Pendulum Effect ]
-- You cannot Special Summon monsters, except "Qli" monsters. This effect cannot be negated. Once per
-- turn: You can pay 800 LP; add 1 "Qli" card from your Deck to your hand, except "Qliphort Scout".
-- ----------------------------------------
-- [ Monster Effect ]
-- Booting in Replica Mode...
-- An error has occurred while executing C:\sophia\zefra.exe
-- Unknown publisher.
-- Allow C:\tierra\qliphort.exe ? <Y/N>...[Y]
-- Booting in Autonomy Mode...
--[[ __CARD_HEADER_END__ ]]

--クリフォート・ツール
function c65518099.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c65518099.splimit)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(65518099,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c65518099.cost)
	e3:SetTarget(c65518099.target)
	e3:SetOperation(c65518099.operation)
	c:RegisterEffect(e3)
end
function c65518099.splimit(e,c,tp,sumtp,sumpos)
	return not c:IsSetCard(0xaa)
end
function c65518099.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)
end
function c65518099.filter(c)
	return c:IsSetCard(0xaa) and not c:IsCode(65518099) and c:IsAbleToHand()
end
function c65518099.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65518099.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c65518099.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c65518099.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
