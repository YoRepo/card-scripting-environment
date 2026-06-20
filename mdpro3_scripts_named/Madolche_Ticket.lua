--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 魔偶甜点券  (ID: 60470713)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 113
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡在魔法与陷阱区域存在的状态，自己的场上（表侧表示）·墓地的「魔偶甜点」卡因效果回到自己的手卡·卡组的场合发动。从卡组把1只「魔偶甜点」怪兽加入手卡。自己场上有天使族「魔偶甜点」怪兽存在的场合
-- ，也能不加入手卡攻击表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--マドルチェ・チケット
function c60470713.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(60470713,0))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,60470713)
	e2:SetCode(EVENT_TO_DECK)
	e2:SetCondition(c60470713.condition)
	e2:SetTarget(c60470713.target)
	e2:SetOperation(c60470713.operation)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_TO_HAND)
	c:RegisterEffect(e3)
end
function c60470713.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousControler(tp)
		and (c:IsPreviousLocation(LOCATION_GRAVE) or (c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP)))
		and c:IsSetCard(0x71) and not c:IsLocation(LOCATION_EXTRA)
end
function c60470713.condition(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and eg:IsExists(c60470713.cfilter,1,nil,tp)
end
function c60470713.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c60470713.mfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x71) and c:IsRace(RACE_FAIRY)
end
function c60470713.filter(c,e,tp,chk)
	return c:IsSetCard(0x71) and c:IsType(TYPE_MONSTER)
		and (c:IsAbleToHand() or chk and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK))
end
function c60470713.operation(e,tp,eg,ep,ev,re,r,rp)
	local b=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c60470713.mfilter,tp,LOCATION_MZONE,0,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c60470713.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp,b)
	local tc=g:GetFirst()
	if tc then
		if b and tc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK)
			and (not tc:IsAbleToHand() or Duel.SelectOption(tp,1190,1152)==1) then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		else
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		end
	end
end
