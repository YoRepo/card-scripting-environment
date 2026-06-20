--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 圣天树之月桂精  (ID: 7984540)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Plant
-- ATK 0 | LINK
-- Setcode: 8536
--
-- Effect Text:
-- 植物族怪兽2只
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡不会被作为攻击对象（自己场上只有被这个效果适用的怪兽存在的状态中对方的攻击变成对自己的直接攻击）。
-- ②：把自己场上1只怪兽解放，以「圣天树之月桂精」以外的自己墓地2只植物族连接怪兽为对象才能发动。那些怪兽回到额外卡组。
--[[ __CARD_HEADER_END__ ]]

--聖天樹の月桂精
function c7984540.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_PLANT),2,2)
	c:EnableReviveLimit()
	--untargetable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--todeck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(7984540,0))
	e2:SetCategory(CATEGORY_TOEXTRA)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,7984540)
	e2:SetCost(c7984540.tdcost)
	e2:SetTarget(c7984540.tdtg)
	e2:SetOperation(c7984540.tdop)
	c:RegisterEffect(e2)
end
function c7984540.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c7984540.tdfilter(c)
	return c:IsType(TYPE_LINK) and c:IsRace(RACE_PLANT) and not c:IsCode(7984540) and c:IsAbleToExtra()
end
function c7984540.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c7984540.tdfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c7984540.tdfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(7984540,1))
	local g=Duel.SelectTarget(tp,c7984540.tdfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,g:GetCount(),0,0)
end
function c7984540.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=tg:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>0 then
		Duel.SendtoDeck(sg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
