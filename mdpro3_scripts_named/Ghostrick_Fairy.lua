--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 鬼计妖精  (ID: 36239585)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 2
-- ATK 900 | DEF 1000
-- Setcode: 141
--
-- Effect Text:
-- 自己场上有「鬼计」怪兽存在的场合才能让这张卡表侧表示召唤。
-- ①：自己主要阶段才能发动。这张卡变成里侧守备表示（1回合只有1次）。
-- ②：这张卡反转时，以自己墓地1张「鬼计」卡为对象才能发动。那张卡在自己场上盖放。那张卡从场上离开的场合除外。那之后，可以选最多有自己场上盖放的卡数量的对方场上的表侧表示怪兽变成里侧守备表示。
--[[ __CARD_HEADER_END__ ]]

--ゴーストリックの妖精
function c36239585.initial_effect(c)
	--summon limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c36239585.sumcon)
	c:RegisterEffect(e1)
	--turn set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(36239585,0))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c36239585.postg)
	e2:SetOperation(c36239585.posop)
	c:RegisterEffect(e2)
	--set card
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(36239585,1))
	e3:SetCategory(CATEGORY_MSET+CATEGORY_SSET)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_FLIP)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetTarget(c36239585.settg)
	e3:SetOperation(c36239585.setop)
	c:RegisterEffect(e3)
end
function c36239585.sfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x8d)
end
function c36239585.sumcon(e)
	return not Duel.IsExistingMatchingCard(c36239585.sfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c36239585.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(36239585)==0 end
	c:RegisterFlagEffect(36239585,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c36239585.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	end
end
function c36239585.setfilter(c,e,tp)
	if not c:IsSetCard(0x8d) then return false end
	if c:IsType(TYPE_MONSTER) then
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
	else return c:IsSSetable() end
end
function c36239585.posfilter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c36239585.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c36239585.setfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c36239585.setfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectTarget(tp,c36239585.setfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetFirst():IsType(TYPE_MONSTER) then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_POSITION+CATEGORY_MSET)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	else
		e:SetCategory(CATEGORY_POSITION+CATEGORY_SSET+CATEGORY_MSET)
		Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
	end
end
function c36239585.setop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local res=0
	if tc:IsType(TYPE_MONSTER) then
		res=Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
		if res~=0 then Duel.ConfirmCards(1-tp,tc) end
	else
		res=Duel.SSet(tp,tc)
	end
	if res~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		tc:RegisterEffect(e1,true)
		local ct=Duel.GetMatchingGroupCount(Card.IsFacedown,tp,LOCATION_ONFIELD,0,nil)
		if ct>0 and Duel.IsExistingMatchingCard(c36239585.posfilter,tp,0,LOCATION_MZONE,1,nil)
			and Duel.SelectYesNo(tp,aux.Stringid(36239585,2)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
			local g=Duel.SelectMatchingCard(tp,c36239585.posfilter,tp,0,LOCATION_MZONE,1,ct,nil)
			Duel.HintSelection(g)
			Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
		end
	end
end
