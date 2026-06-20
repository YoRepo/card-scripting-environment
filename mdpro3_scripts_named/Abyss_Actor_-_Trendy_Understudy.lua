--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 魔界剧团-花花配角  (ID: 39024589)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level 2
-- Pendulum Scales: L8 / R8
-- ATK 700 | DEF 700
-- Setcode: 4332
--
-- Effect Text:
-- ←8 【灵摆】 8→
-- ①：自己灵摆召唤成功时才能发动。从自己的额外卡组把1只表侧表示的1星或者8星的「魔界剧团」灵摆怪兽加入手卡。
-- 【怪兽效果】
-- 这个卡名的怪兽效果1回合只能使用1次。
-- ①：自己的灵摆区域有2张「魔界剧团」卡存在的场合，把这张卡解放才能发动。从手卡以及自己的额外卡组的表侧表示怪兽之中把1只1星或者8星的「魔界剧团」灵摆怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--魔界劇団－ダンディ・バイプレイヤー
function c39024589.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39024589,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(c39024589.thcon)
	e1:SetTarget(c39024589.thtg)
	e1:SetOperation(c39024589.thop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(39024589,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,39024589)
	e2:SetCondition(c39024589.spcon)
	e2:SetCost(c39024589.spcost)
	e2:SetTarget(c39024589.sptg)
	e2:SetOperation(c39024589.spop)
	c:RegisterEffect(e2)
end
function c39024589.cfilter(c,tp)
	return c:IsSummonPlayer(tp) and c:IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c39024589.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c39024589.cfilter,1,nil,tp)
end
function c39024589.thfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x10ec) and c:IsLevel(1,8) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c39024589.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c39024589.thfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_EXTRA)
end
function c39024589.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c39024589.thfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c39024589.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_PZONE,0,2,nil,0x10ec)
end
function c39024589.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c39024589.filter(c,e,tp,mc)
	return (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsSetCard(0x10ec)
		and c:IsLevel(1,8) and c:IsType(TYPE_PENDULUM) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and (c:IsLocation(LOCATION_HAND) and Duel.GetMZoneCount(tp,mc)>0
			or c:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0)
end
function c39024589.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c39024589.filter,tp,LOCATION_HAND+LOCATION_EXTRA,0,1,nil,e,tp,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_EXTRA)
end
function c39024589.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c39024589.filter,tp,LOCATION_HAND+LOCATION_EXTRA,0,1,1,nil,e,tp,nil)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
