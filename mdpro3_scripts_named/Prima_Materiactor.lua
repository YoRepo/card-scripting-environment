--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Prima Materiactor  (ID: 57448410)
-- Type: Monster / Normal / Pendulum
-- Attribute: LIGHT
-- Race: Dragon
-- Level: 3
-- ATK 0 | DEF 0
-- Pendulum Scale: L1 / R1
-- Setcode: 0x160
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 1
-- [ Pendulum Effect ]
-- Xyz Monsters you control gain 100 ATK for each Xyz Material on the field. You can target 1
-- "Materiactor" Xyz Monster you control; attach this card to it as material, then draw 1 card. You can
-- only use this effect of "Prima Materiactor" once per turn.
-- ----------------------------------------
-- [ Monster Effect ]
-- An alien life form that suddenly flew in from the heavens far away. Many researchers have tried to
-- determine its true identity, but its luminosity and the miasma emitted have long shrouded its
-- existence in mystery, making it extremely difficult to see the full extent of its existence.
-- Recently, however, a number of new species have been discovered by up-and-coming researchers, and it
-- appears that the full extent of the species' existence is finally being revealed.
--[[ __CARD_HEADER_END__ ]]

--プリマ・マテリアクトル
local s,id,o=GetID()
function s.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_XYZ))
	e1:SetValue(s.val)
	c:RegisterEffect(e1)
	--material
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1,id)
	e2:SetTarget(s.mattg)
	e2:SetOperation(s.matop)
	c:RegisterEffect(e2)
end
function s.val(e,c)
	return Duel.GetOverlayCount(e:GetHandlerPlayer(),1,1)*100
end
function s.matfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x160) and c:IsType(TYPE_XYZ)
end
function s.mattg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and s.matfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.matfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsPlayerCanDraw(tp,1)
		and e:GetHandler():IsCanOverlay() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,s.matfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function s.matop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) and c:IsCanOverlay() then
		Duel.Overlay(tc,Group.FromCards(c))
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
