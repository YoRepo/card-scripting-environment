--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Shadow Ghoul of the Labyrinth  (ID: 62411811)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level: 5
-- ATK 1600 | DEF 1300
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can discard this card; add 1 "Labyrinth Wall" card from your Deck to your hand.
-- At the start of the Damage Step, if your opponent's monster battles, while you control a "Labyrinth
-- Wall" card: You can banish this card from your GY; destroy that opponent's monster.
-- You can only use each effect of "Shadow Ghoul of the Labyrinth" once per turn.
--[[ __CARD_HEADER_END__ ]]

--迷宮に潜むシャドウ・グール
function c62411811.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62411811,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,62411811)
	e1:SetCost(c62411811.thcost)
	e1:SetTarget(c62411811.thtg)
	e1:SetOperation(c62411811.thop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,62411812)
	e2:SetCondition(c62411811.descon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c62411811.destg)
	e2:SetOperation(c62411811.desop)
	c:RegisterEffect(e2)
end
function c62411811.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c62411811.thfilter(c)
	return c:IsSetCard(0x193) and c:IsAbleToHand()
end
function c62411811.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c62411811.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c62411811.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tg=Duel.SelectMatchingCard(tp,c62411811.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #tg>0 and Duel.SendtoHand(tg,nil,REASON_EFFECT)>0 then
		Duel.ConfirmCards(1-tp,tg)
	end
end
function c62411811.descfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x193)
end
function c62411811.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetBattleMonster(1-tp)
	if not tc then return false end
	e:SetLabelObject(tc)
	return Duel.IsExistingMatchingCard(c62411811.descfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c62411811.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c62411811.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
