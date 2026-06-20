--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 融合征兵  (ID: 17194258)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 70
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：把额外卡组1只融合怪兽给对方观看，那只怪兽有卡名记述的1只融合素材怪兽从自己的卡组·墓地加入手卡。这张卡的发动后，直到回合结束时自己不能把这个效果加入手卡的怪兽以及那些同名怪兽通常召唤·特殊召唤，
-- 不能把那些怪兽效果发动。
--[[ __CARD_HEADER_END__ ]]

--融合徴兵
function c17194258.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,17194258+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c17194258.target)
	e1:SetOperation(c17194258.activate)
	c:RegisterEffect(e1)
end
function c17194258.filter1(c,tp)
	return c:IsType(TYPE_FUSION) and Duel.IsExistingMatchingCard(c17194258.filter2,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,c)
end
function c17194258.filter2(c,fc)
	return aux.IsMaterialListCode(fc,c:GetCode()) and c:IsAbleToHand()
end
function c17194258.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17194258.filter1,tp,LOCATION_EXTRA,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c17194258.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local cg=Duel.SelectMatchingCard(tp,c17194258.filter1,tp,LOCATION_EXTRA,0,1,1,nil,tp)
	if cg:GetCount()==0 then return end
	Duel.ConfirmCards(1-tp,cg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c17194258.filter2),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,cg:GetFirst())
	local tc=g:GetFirst()
	if not tc then return end
	if Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_HAND) then
		Duel.ConfirmCards(1-tp,tc)
		if not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_SUMMON)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,0)
		e1:SetTarget(c17194258.sumlimit)
		e1:SetLabel(tc:GetCode())
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		Duel.RegisterEffect(e2,tp)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CANNOT_MSET)
		Duel.RegisterEffect(e3,tp)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_CANNOT_ACTIVATE)
		e4:SetValue(c17194258.aclimit)
		Duel.RegisterEffect(e4,tp)
	end
end
function c17194258.sumlimit(e,c)
	return c:IsCode(e:GetLabel())
end
function c17194258.aclimit(e,re,tp)
	return re:GetHandler():IsCode(e:GetLabel()) and re:IsActiveType(TYPE_MONSTER)
end
