--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 阳龙果 凤梨  (ID: 35311929)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Plant
-- Level 1
-- ATK 800 | DEF 0
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡被怪兽的效果从卡组送去墓地的场合才能发动。这张卡特殊召唤。自己场上有其他的植物族怪兽存在的场合，可以再选场上1只怪兽那个攻击力·守备力变成一半。
-- ②：1回合1次，场上的这张卡被战斗·效果破坏的场合，可以作为代替从卡组把1只植物族怪兽送去墓地。
--[[ __CARD_HEADER_END__ ]]

--陽竜果フォンリー
function c35311929.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(35311929,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,35311929)
	e1:SetCondition(c35311929.spcon)
	e1:SetTarget(c35311929.sptg)
	e1:SetOperation(c35311929.spop)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetCountLimit(1)
	e2:SetTarget(c35311929.desreptg)
	c:RegisterEffect(e2)
end
function c35311929.spcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and re:IsActiveType(TYPE_MONSTER)
		and e:GetHandler():IsPreviousLocation(LOCATION_DECK)
end
function c35311929.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c35311929.checkfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c35311929.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if e:GetHandler():IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0
		and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(c35311929.checkfilter,tp,LOCATION_MZONE,0,1,c)
		and Duel.SelectYesNo(tp,aux.Stringid(35311929,1)) then
			Duel.BreakEffect()
			local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
			Duel.HintSelection(g)
			local tc=g:GetFirst()
			if tc then
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_SET_ATTACK_FINAL)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD)
				e1:SetValue(math.ceil(tc:GetAttack()/2))
				tc:RegisterEffect(e1)
				local e2=Effect.CreateEffect(c)
				e2:SetType(EFFECT_TYPE_SINGLE)
				e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
				e2:SetReset(RESET_EVENT+RESETS_STANDARD)
				e2:SetValue(math.ceil(tc:GetDefense()/2))
				tc:RegisterEffect(e2)
			end
	end
end
function c35311929.desrepfilter(c)
	return c:IsRace(RACE_PLANT) and c:IsAbleToGrave()
end
function c35311929.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
		and Duel.IsExistingMatchingCard(c35311929.desrepfilter,tp,LOCATION_DECK,0,1,nil) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,c35311929.desrepfilter,tp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_REPLACE)
		return true
	else return false end
end
