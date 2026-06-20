--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 恐吓爪牙族·莱特哈特  (ID: 53776969)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Beast-Warrior
-- ATK 500 | LINK
-- Setcode: 27263354
--
-- Effect Text:
-- 「恐吓爪牙族」怪兽或者「维萨斯-斯塔弗罗斯特」1只
-- 这张卡连接召唤的场合，若非自己的主要怪兽区域的怪兽则不能作为连接素材。这个卡名的②的效果在决斗中只能使用1次。
-- ①：这张卡在额外怪兽区域连接召唤的场合才能发动。从卡组把1张「肆世坏-恐惧世界」加入手卡。
-- ②：自己场上有「维萨斯-斯塔弗罗斯特」存在的场合才能发动。这张卡从墓地特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--スケアクロー・ライトハート
function c53776969.initial_effect(c)
	aux.AddCodeList(c,56099748,56063182)
	--link summon
	aux.AddLinkProcedure(c,c53776969.mfilter,1,1)
	c:EnableReviveLimit()
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c53776969.thcon)
	e1:SetTarget(c53776969.thtg)
	e1:SetOperation(c53776969.thop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,53776969+EFFECT_COUNT_CODE_DUEL)
	e2:SetCondition(c53776969.spcon)
	e2:SetTarget(c53776969.sptg)
	e2:SetOperation(c53776969.spop)
	c:RegisterEffect(e2)
end
function c53776969.mfilter(c)
	return (c:IsLinkSetCard(0x17a) or c:IsLinkCode(56099748))
		and c:IsLocation(LOCATION_MZONE) and c:GetSequence()<5
end
function c53776969.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_LINK) and c:GetSequence()>4
end
function c53776969.thfilter(c)
	return c:IsCode(56063182) and c:IsAbleToHand()
end
function c53776969.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c53776969.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c53776969.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c53776969.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c53776969.filter(c)
	return c:IsCode(56099748) and c:IsFaceup()
end
function c53776969.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c53776969.filter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c53776969.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c53776969.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
