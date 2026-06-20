--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 双天脚之鸿鹄  (ID: 11759079)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 3
-- ATK 800 | DEF 2000
-- Setcode: 335
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：「双天脚之鸿鹄」以外的自己场上的表侧表示的「双天」怪兽在对方回合被战斗·效果破坏的场合才能发动。这张卡从手卡特殊召唤。那之后，以下效果可以适用。
-- ●选自己场上1只「双天」怪兽破坏，从额外卡组把1只「双天」融合怪兽特殊召唤。
-- ②：这张卡召唤·特殊召唤成功的场合才能发动。从卡组把1张「双天」陷阱卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--双天脚の鴻鵠
function c11759079.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11759079,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,11759079)
	e1:SetCondition(c11759079.spcon)
	e1:SetTarget(c11759079.sptg)
	e1:SetOperation(c11759079.spop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11759079,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,11759080)
	e2:SetTarget(c11759079.thtg)
	e2:SetOperation(c11759079.thop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c11759079.spfilter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsPreviousSetCard(0x14f) and c:GetPreviousCodeOnField()~=11759079
		and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP)
end
function c11759079.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c11759079.spfilter,1,nil,tp) and Duel.GetTurnPlayer()~=tp
end
function c11759079.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c11759079.desfilter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x14f)
		and Duel.IsExistingMatchingCard(c11759079.sffilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c)
end
function c11759079.sffilter(c,e,tp,tc)
	return c:IsSetCard(0x14f) and c:IsType(TYPE_FUSION)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,tc,c)>0
end
function c11759079.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0
		and Duel.IsExistingMatchingCard(c11759079.desfilter,tp,LOCATION_MZONE,0,1,nil,e,tp)
		and Duel.SelectYesNo(tp,aux.Stringid(11759079,2)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,c11759079.desfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
		Duel.HintSelection(g)
		if Duel.Destroy(g,REASON_EFFECT)~=0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=Duel.SelectMatchingCard(tp,c11759079.sffilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,nil)
			if sg:GetCount()>0 then
				Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
			end
		end
	end
end
function c11759079.thfilter(c)
	return c:IsSetCard(0x14f) and c:IsType(TYPE_TRAP) and c:IsAbleToHand()
end
function c11759079.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11759079.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c11759079.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c11759079.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
