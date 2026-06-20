--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 宇宙智者  (ID: 85679527)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Spellcaster
-- Level 7
-- ATK 1500 | DEF 2450
--
-- Effect Text:
-- 这张卡不能通常召唤。从手卡以及自己场上的表侧表示怪兽之中把效果怪兽以外的1只怪兽送去墓地的场合可以特殊召唤。这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡的攻击力上升因为这张卡特殊召唤而送去墓地的怪兽的等级×200。
-- ②：把自己场上1只效果怪兽解放才能发动。从手卡·卡组把1只通常怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--コスモブレイン
function c85679527.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c85679527.sprcon)
	e1:SetTarget(c85679527.sprtg)
	e1:SetOperation(c85679527.sprop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(85679527,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,85679527)
	e2:SetCost(c85679527.spcost)
	e2:SetTarget(c85679527.sptg)
	e2:SetOperation(c85679527.spop)
	c:RegisterEffect(e2)
end
function c85679527.sprfilter(c,tp)
	return (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and not c:IsType(TYPE_EFFECT) and c:IsType(TYPE_MONSTER)
		and c:IsAbleToGraveAsCost() and Duel.GetMZoneCount(tp,c)>0
end
function c85679527.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c85679527.sprfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil,tp)
end
function c85679527.sprtg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c85679527.sprfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c85679527.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local rc=e:GetLabelObject()
	local lv=rc:GetLevel()
	Duel.SendtoGrave(rc,REASON_SPSUMMON)
	if not rc:IsType(TYPE_MONSTER) or lv<=0 then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(lv*200)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
function c85679527.costfilter(c,tp)
	return c:IsType(TYPE_EFFECT) and Duel.GetMZoneCount(tp,c,tp)>0
end
function c85679527.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c85679527.costfilter,1,nil,tp) end
	local g=Duel.SelectReleaseGroup(tp,c85679527.costfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c85679527.spfilter(c,e,tp)
	return c:IsType(TYPE_NORMAL) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c85679527.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c85679527.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK)
end
function c85679527.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c85679527.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
