--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: PSY骨架王·Λ  (ID: 8802510)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Psychic
-- ATK 1700 | LINK
-- Setcode: 193
--
-- Effect Text:
-- 衍生物以外的怪兽2只
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要这张卡在怪兽区域存在，自己在自己场上有怪兽存在的场合也能把手卡的「PSY骨架装备」怪兽的效果发动。
-- ②：这张卡已在怪兽区域存在的状态，这张卡以外的自己场上的表侧表示的念动力族怪兽被除外的场合才能发动。这个回合的结束阶段，从卡组把1张「PSY骨架」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--PSYフレームロード・Λ
function c8802510.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.NOT(aux.FilterBoolFunction(Card.IsLinkType,TYPE_TOKEN)),2,2)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(8802510)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,0)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(8802510,0))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_REMOVE)
	e2:SetCountLimit(1,8802510)
	e2:SetCondition(c8802510.regcon)
	e2:SetOperation(c8802510.regop)
	c:RegisterEffect(e2)
end
function c8802510.cfilter(c,tp)
	return c:IsFaceup() and c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousLocation(LOCATION_MZONE)
		and bit.band(c:GetPreviousRaceOnField(),RACE_PSYCHO)~=0 and c:IsPreviousControler(tp) and c:IsRace(RACE_PSYCHO)
end
function c8802510.regcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c8802510.cfilter,1,nil,tp)
end
function c8802510.regop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetCondition(c8802510.thcon)
	e1:SetOperation(c8802510.thop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c8802510.thfilter(c)
	return c:IsSetCard(0xc1) and c:IsAbleToHand()
end
function c8802510.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c8802510.thfilter,tp,LOCATION_DECK,0,1,nil)
end
function c8802510.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,8802510)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c8802510.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
