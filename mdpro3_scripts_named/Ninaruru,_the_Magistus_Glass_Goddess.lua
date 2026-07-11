--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Ninaruru, the Magistus Glass Goddess  (ID: 8660395)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Rock
-- Rank: 4
-- ATK 1800 | DEF 2400
-- Setcode: 0x150
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 4 Spellcaster monsters
-- While this card is an Equip Card, the equipped monster can make up to 2 attacks on monsters during
-- each Battle Phase.
-- You can only use each of the following effects of "Ninaruru, the Magistus Glass Goddess" once per
-- turn.
-- You can detach 1 material from this card, then target 1 Level 4 or higher Spellcaster monster in
-- your GY; add it to your hand.
-- While this card is equipped to a monster: You can target 1 "Magistus" card in your Spell & Trap Zone
-- and 1 Spell/Trap your opponent controls; destroy them.
--[[ __CARD_HEADER_END__ ]]

--結晶の女神ニンアルル
function c8660395.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),4,2)
	c:EnableReviveLimit()
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(8660395,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,8660395)
	e1:SetCost(c8660395.thcost)
	e1:SetTarget(c8660395.thtg)
	e1:SetOperation(c8660395.thop)
	c:RegisterEffect(e1)
	--extra attack monster
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--destroy(equip)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(8660395,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,8660396)
	e3:SetCondition(c8660395.descon)
	e3:SetTarget(c8660395.destg)
	e3:SetOperation(c8660395.desop)
	c:RegisterEffect(e3)
end
function c8660395.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c8660395.thfilter(c)
	return c:IsLevelAbove(4) and c:IsRace(RACE_SPELLCASTER) and c:IsAbleToHand()
end
function c8660395.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c8660395.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c8660395.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c8660395.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c8660395.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c8660395.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget()
end
function c8660395.desfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x150) and c:GetSequence()<5
end
function c8660395.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c8660395.desfilter,tp,LOCATION_SZONE,0,1,nil)
		and Duel.IsExistingTarget(Card.IsType,tp,0,LOCATION_ONFIELD,1,nil,TYPE_SPELL+TYPE_TRAP) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c8660395.desfilter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,Card.IsType,tp,0,LOCATION_ONFIELD,1,1,nil,TYPE_SPELL+TYPE_TRAP)
	g:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c8660395.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if #g>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
