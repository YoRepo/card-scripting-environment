--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 雷风魔神-门之守护神  (ID: 34904525)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Thunder
-- Level 9
-- ATK 2500 | DEF 2200
-- Setcode: 4178
--
-- Effect Text:
-- 「雷魔神-桑迦」＋「风魔神-修迦」
-- 把自己场上的上记的卡除外的场合才能特殊召唤。这个卡名的①的效果1回合只能使用1次。
-- ①：自己主要阶段才能发动。把有「雷魔神-桑迦」「风魔神-修迦」「水魔神-斯迦」的卡名全部记述的1张魔法·陷阱卡从卡组加入手卡。
-- ②：特殊召唤的表侧表示的这张卡因对方从场上离开的场合才能发动。自己的除外状态的1只「雷魔神-桑迦」或「风魔神-修迦」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--雷風魔神－ゲート・ガーディアン
function c34904525.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddCodeList(c,98434877)
	aux.AddFusionProcCode2(c,25955164,62340868,true,true)
	aux.AddContactFusionProcedure(c,Card.IsAbleToRemoveAsCost,LOCATION_ONFIELD,0,Duel.Remove,POS_FACEUP,REASON_COST)
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e0)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(34904525,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,34904525)
	e1:SetTarget(c34904525.thtg)
	e1:SetOperation(c34904525.thop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(34904525,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(c34904525.spcon)
	e2:SetTarget(c34904525.sptg)
	e2:SetOperation(c34904525.spop)
	c:RegisterEffect(e2)
end
function c34904525.thfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
		and aux.IsCodeListed(c,25955164) and aux.IsCodeListed(c,62340868) and aux.IsCodeListed(c,98434877)
end
function c34904525.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c34904525.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c34904525.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tg=Duel.SelectMatchingCard(tp,c34904525.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #tg>0 and Duel.SendtoHand(tg,nil,REASON_EFFECT)>0 then
		Duel.ConfirmCards(1-tp,tg)
	end
end
function c34904525.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_SPECIAL) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousControler(tp) and c:GetReasonPlayer()==1-tp
end
function c34904525.spfilter(c,e,tp)
	return c:IsCode(25955164,62340868) and c:IsFaceup() and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c34904525.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c34904525.spfilter,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_REMOVED)
end
function c34904525.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c34904525.spfilter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
