--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 死狱乡演员·奎里蒂斯  (ID: 72272462)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Fiend
-- Level 8
-- ATK 2500 | DEF 2500
-- Setcode: 356
--
-- Effect Text:
-- 「死狱乡」怪兽＋光·暗属性怪兽
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己·对方的主要阶段才能发动。除8星以上的融合怪兽外的场上的全部怪兽的攻击力直到回合结束时变成0。
-- ②：表侧表示的这张卡因对方的效果从场上离开的场合才能发动。从卡组选1只「死狱乡」怪兽或者「阿不思的落胤」加入手卡或特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--デスピアン・クエリティス
function c72272462.initial_effect(c)
	aux.AddCodeList(c,68468459)
	--fusion summon
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x164),c72272462.matfilter,true)
	--atk change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(72272462,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,72272462)
	e1:SetCondition(c72272462.atkcon)
	e1:SetTarget(c72272462.atktg)
	e1:SetOperation(c72272462.atkop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(72272462,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCountLimit(1,72272463)
	e2:SetCondition(c72272462.thcon)
	e2:SetTarget(c72272462.thtg)
	e2:SetOperation(c72272462.thop)
	c:RegisterEffect(e2)
end
function c72272462.matfilter(c)
	return c:IsFusionAttribute(ATTRIBUTE_LIGHT+ATTRIBUTE_DARK)
end
function c72272462.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_MAIN1 or ph==PHASE_MAIN2
end
function c72272462.atkfilter(c)
	return c:IsFaceup() and not (c:IsLevelAbove(8) and c:IsType(TYPE_FUSION))
end
function c72272462.atkfilter1(c)
	return c72272462.atkfilter(c) and c:GetAttack()>0
end
function c72272462.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c72272462.atkfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c72272462.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c72272462.atkfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c72272462.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp==1-tp and c:IsReason(REASON_EFFECT) and c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousControler(tp)
end
function c72272462.thfilter(c,e,tp,check)
	return (c:IsSetCard(0x164) and c:IsType(TYPE_MONSTER) or c:IsCode(68468459))
		and (c:IsAbleToHand() or check and c:IsCanBeSpecialSummoned(e,0,tp,false,false))
end
function c72272462.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local check=Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	if chk==0 then return Duel.IsExistingMatchingCard(c72272462.thfilter,tp,LOCATION_DECK,0,1,nil,e,tp,check) end
end
function c72272462.thop(e,tp,eg,ep,ev,re,r,rp)
	local check=Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local g=Duel.SelectMatchingCard(tp,c72272462.thfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,check)
	local tc=g:GetFirst()
	if tc then
		if tc:IsAbleToHand() and (not (check and tc:IsCanBeSpecialSummoned(e,0,tp,false,false)) or Duel.SelectOption(tp,1190,1152)==0) then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		else
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
