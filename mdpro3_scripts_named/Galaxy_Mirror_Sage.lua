--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 银河魔镜士  (ID: 98263709)
-- Type: Monster / Effect / Toon
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 3
-- ATK 0 | DEF 800
-- Setcode: 123
--
-- Effect Text:
-- 反转：自己回复自己墓地的名字带有「银河」的怪兽数量×500基本分。此外，反转过的这张卡被破坏送去墓地时，可以从自己的卡组·墓地选1只4星以下的名字带有「银河」的怪兽里侧守备表示特殊召唤。这个效果特殊召
-- 唤的怪兽从场上离开的场合从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--銀河魔鏡士
function c98263709.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98263709,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTarget(c98263709.rectg)
	e1:SetOperation(c98263709.recop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_FLIP)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetOperation(c98263709.flipop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(98263709,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCondition(c98263709.spcon)
	e3:SetTarget(c98263709.sptg)
	e3:SetOperation(c98263709.spop)
	c:RegisterEffect(e3)
end
function c98263709.filter(c)
	return c:IsSetCard(0x7b) and c:IsType(TYPE_MONSTER)
end
function c98263709.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local val=Duel.GetMatchingGroupCount(c98263709.filter,tp,LOCATION_GRAVE,0,nil)*500
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(val)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,val)
end
function c98263709.recop(e,tp,eg,ep,ev,re,r,rp)
	local val=Duel.GetMatchingGroupCount(c98263709.filter,tp,LOCATION_GRAVE,0,nil)*500
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Recover(p,val,REASON_EFFECT)
end
function c98263709.flipop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(98263709,RESET_EVENT+0x57a0000,0,0)
end
function c98263709.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(98263709)~=0 and e:GetHandler():IsReason(REASON_DESTROY)
end
function c98263709.spfilter(c,e,tp)
	return c:IsSetCard(0x7b) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
end
function c98263709.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c98263709.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c98263709.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c98263709.spfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if not tc then return end
	if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		tc:RegisterEffect(e1,true)
		Duel.ConfirmCards(1-tp,tc)
	end
	Duel.SpecialSummonComplete()
end
