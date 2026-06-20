--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 魔圣骑士 兰斯洛特  (ID: 95772051)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 5
-- ATK 2000 | DEF 800
-- Setcode: 11014266
--
-- Effect Text:
-- 把自己场上表侧表示存在的1只光属性的通常怪兽送去墓地才能发动。这张卡从手卡或者墓地特殊召唤。此外，把自己场上1只名字带有「圣骑士」的怪兽解放才能发动。从卡组把1张名字带有「圣剑」的卡加入手卡。「魔圣骑
-- 士 兰斯洛特」的这个效果1回合只能使用1次。此外，「魔圣骑士 兰斯洛特」在自己场上只能有1只表侧表示存在。
--[[ __CARD_HEADER_END__ ]]

--魔聖騎士ランスロット
function c95772051.initial_effect(c)
	c:SetUniqueOnField(1,0,95772051)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95772051,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCost(c95772051.spcost)
	e1:SetTarget(c95772051.sptg)
	e1:SetOperation(c95772051.spop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(95772051,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,95772051)
	e2:SetCost(c95772051.thcost)
	e2:SetTarget(c95772051.thtg)
	e2:SetOperation(c95772051.thop)
	c:RegisterEffect(e2)
end
function c95772051.spfilter(c,ft)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsType(TYPE_NORMAL) and c:IsAbleToGraveAsCost()
		and (ft>0 or c:GetSequence()<5)
end
function c95772051.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return ft>-1 and Duel.IsExistingMatchingCard(c95772051.spfilter,tp,LOCATION_MZONE,0,1,nil,ft) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c95772051.spfilter,tp,LOCATION_MZONE,0,1,1,nil,ft)
	Duel.SendtoGrave(g,REASON_COST)
end
function c95772051.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c95772051.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c95772051.thfilter(c)
	return c:IsSetCard(0x207a) and c:IsAbleToHand()
end
function c95772051.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x107a) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x107a)
	Duel.Release(g,REASON_COST)
end
function c95772051.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c95772051.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c95772051.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c95772051.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
