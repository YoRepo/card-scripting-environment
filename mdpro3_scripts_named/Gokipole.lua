--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 蟑螂柱  (ID: 17535764)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level 3
-- ATK 1000 | DEF 1200
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡被送去墓地的场合才能发动。从卡组把1只4星昆虫族怪兽加入手卡。这个效果把通常怪兽加入的场合，可以再把那只怪兽从手卡特殊召唤。那之后，可以选持有这个效果特殊召唤的怪兽的攻击力以上的攻击力的场上
-- 1只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--ゴキポール
function c17535764.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(17535764,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,17535764)
	e1:SetTarget(c17535764.thtg)
	e1:SetOperation(c17535764.tgop)
	c:RegisterEffect(e1)
end
function c17535764.thfilter(c)
	return c:IsLevel(4) and c:IsRace(RACE_INSECT) and c:IsAbleToHand()
end
function c17535764.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17535764.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c17535764.desfilter(c,atk)
	return c:IsFaceup() and c:IsAttackAbove(atk)
end
function c17535764.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tc=Duel.SelectMatchingCard(tp,c17535764.thfilter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
	if tc and Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_HAND) then
		Duel.ConfirmCards(1-tp,tc)
		if tc:IsType(TYPE_NORMAL) and tc:IsCanBeSpecialSummoned(e,0,tp,false,false)
			and Duel.SelectYesNo(tp,aux.Stringid(17535764,1)) then
			Duel.BreakEffect()
			if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
				local g=Duel.GetMatchingGroup(c17535764.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tc:GetAttack())
				if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(17535764,2)) then
					Duel.BreakEffect()
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
					local tc2=g:Select(tp,1,1,nil)
					Duel.Destroy(tc2,REASON_EFFECT)
				end
			end
		end
	end
end
