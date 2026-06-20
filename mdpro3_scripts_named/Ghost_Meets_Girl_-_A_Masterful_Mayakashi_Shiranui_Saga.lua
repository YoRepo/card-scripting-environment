--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 逢华妖丽谭-魔妖不知火语  (ID: 62219643)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 14221601
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：把自己场上1只「魔妖」同调·连接怪兽或者「不知火」同调·连接怪兽解放才能发动。这个回合，双方不能从手卡·卡组·额外卡组把怪兽特殊召唤。
-- ②：把墓地的这张卡除外，以除外的1只自己的不死族怪兽为对象才能发动。那只怪兽回到墓地。
--[[ __CARD_HEADER_END__ ]]

--逢華妖麗譚－魔妖不知火語
function c62219643.initial_effect(c)
	--spsummon limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCountLimit(1,62219643)
	e1:SetCost(c62219643.limcost)
	e1:SetOperation(c62219643.limop)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCountLimit(1,62219643)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c62219643.tgtg)
	e2:SetOperation(c62219643.tgop)
	c:RegisterEffect(e2)
end
function c62219643.rfilter(c,tp)
	return c:IsSetCard(0x121,0xd9) and c:IsType(TYPE_SYNCHRO+TYPE_LINK) and (c:IsControler(tp) or c:IsFaceup())
end
function c62219643.limcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c62219643.rfilter,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectReleaseGroup(tp,c62219643.rfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c62219643.limop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,1)
	e1:SetTarget(c62219643.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	--cant spsummon from main deck check
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(63060238)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c62219643.splimit(e,c)
	return c:IsLocation(LOCATION_HAND+LOCATION_DECK+LOCATION_EXTRA)
end
function c62219643.tgfilter(c)
	return c:IsRace(RACE_ZOMBIE) and c:IsFaceup() and c:IsAbleToGrave()
end
function c62219643.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c62219643.tgfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c62219643.tgfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,c62219643.tgfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c62219643.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_RETURN)
	end
end
