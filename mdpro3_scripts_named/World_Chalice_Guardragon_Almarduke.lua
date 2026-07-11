--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: World Chalice Guardragon Almarduke  (ID: 95793022)
-- Type: Monster / Effect / Fusion
-- Attribute: WIND
-- Race: Dragon
-- Level: 9
-- ATK 3000 | DEF 2600
-- Setcode: 0xfd
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Link Monsters
-- Must first be either Fusion Summoned, or Special Summoned from your Extra Deck by Tributing the
-- above cards you control (in which case you do not use "Polymerization").
-- This card can attack all monsters your opponent controls once each.
-- When an attack is declared involving this card and an opponent's Link Monster: You can banish 1 Link
-- Monster with the same Link Rating as that monster from your field or GY; destroy that opponent's
-- monster, and if you do, inflict damage to your opponent equal to its original ATK.
--[[ __CARD_HEADER_END__ ]]

--星杯の守護竜アルマドゥーク
function c95793022.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,c95793022.ffilter,3,true)
	aux.AddContactFusionProcedure(c,aux.FilterBoolFunction(Card.IsReleasable,REASON_SPSUMMON),LOCATION_MZONE,0,Duel.Release,REASON_SPSUMMON+REASON_MATERIAL)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c95793022.splimit)
	c:RegisterEffect(e1)
	--attack all
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_ATTACK_ALL)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--attack
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(95793022,0))
	e4:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c95793022.atkcon)
	e4:SetCost(c95793022.atkcost)
	e4:SetTarget(c95793022.atktg)
	e4:SetOperation(c95793022.atkop)
	c:RegisterEffect(e4)
end
function c95793022.ffilter(c)
	return c:IsFusionType(TYPE_LINK)
end
function c95793022.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or aux.fuslimit(e,se,sp,st)
end
function c95793022.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	e:SetLabelObject(tc)
	return tc and tc:IsFaceup() and tc:IsControler(1-tp) and tc:IsType(TYPE_LINK)
end
function c95793022.cfilter(c,lk)
	return c:IsType(TYPE_LINK) and c:IsLink(lk) and c:IsAbleToRemoveAsCost()
end
function c95793022.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return Duel.IsExistingMatchingCard(c95793022.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,nil,tc:GetLink()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c95793022.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,1,1,nil,tc:GetLink())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c95793022.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=e:GetLabelObject()
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,tc:GetBaseAttack())
end
function c95793022.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local dam=tc:GetBaseAttack()
	if tc:IsRelateToBattle() and tc:IsControler(1-tp) and Duel.Destroy(tc,REASON_EFFECT)~=0 and dam>0 then
		Duel.Damage(1-tp,dam,REASON_EFFECT)
	end
end
