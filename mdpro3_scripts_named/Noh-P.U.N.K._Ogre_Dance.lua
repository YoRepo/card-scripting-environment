--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 能朋克 鬼能乐  (ID: 81914447)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 8
-- ATK 2500 | DEF 2000
-- Setcode: 369
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：把自己场上1只「朋克」怪兽解放才能发动。这张卡从手卡特殊召唤。
-- ②：把手卡·场上的这张卡送去墓地才能发动。从卡组把1只8星以外的「朋克」怪兽加入手卡。
-- ③：1回合1次，对方把怪兽的效果发动时才能发动。这张卡的攻击力直到回合结束时上升那只对方怪兽的原本攻击力数值。
--[[ __CARD_HEADER_END__ ]]

--No－P.U.N.K.オーガ・ナンバー
function c81914447.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81914447,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,81914447)
	e1:SetCost(c81914447.spcost)
	e1:SetTarget(c81914447.sptg)
	e1:SetOperation(c81914447.spop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(81914447,1))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e2:SetCountLimit(1,81914448)
	e2:SetCost(c81914447.thcost)
	e2:SetTarget(c81914447.thtg)
	e2:SetOperation(c81914447.thop)
	c:RegisterEffect(e2)
	--atk up
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(81914447,2))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c81914447.atkcon)
	e3:SetOperation(c81914447.atkop)
	c:RegisterEffect(e3)
end
function c81914447.spfilter(c,tp)
	return Duel.GetMZoneCount(tp,c)>0 and c:IsSetCard(0x171) and (c:IsControler(tp) or c:IsFaceup())
end
function c81914447.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c81914447.spfilter,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectReleaseGroup(tp,c81914447.spfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c81914447.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c81914447.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c81914447.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c81914447.thfilter(c)
	return c:IsSetCard(0x171) and c:IsType(TYPE_MONSTER) and not c:IsLevel(8) and c:IsAbleToHand()
end
function c81914447.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81914447.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c81914447.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c81914447.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c81914447.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_MONSTER) and rp==1-tp
end
function c81914447.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=re:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local atk=0
		if rc:IsRelateToEffect(re) and (rc:IsFaceup() or not rc:IsLocation(LOCATION_MZONE)) then
			if rc:IsControler(1-tp) then
				atk=rc:GetBaseAttack()
			end
		else
			atk=rc:GetTextAttack()
		end
		if atk>0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(atk)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
		end
	end
end
