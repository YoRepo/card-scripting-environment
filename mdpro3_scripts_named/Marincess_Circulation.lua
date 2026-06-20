--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 海晶少女环流  (ID: 83723605)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 299
--
-- Effect Text:
-- 自己场上有连接3以上的「海晶少女」怪兽存在的场合，这张卡的发动从手卡也能用。
-- ①：以自己场上1只水属性连接怪兽为对象才能发动。那只怪兽回到持有者的额外卡组，和那只怪兽是卡名不同并是连接标记数量相同的1只「海晶少女」连接怪兽当作连接召唤从额外卡组特殊召唤。这个回合，这个效果特殊召
-- 唤的怪兽不能直接攻击，不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--海晶乙女環流
function c83723605.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOEXTRA+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetTarget(c83723605.target)
	e1:SetOperation(c83723605.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(83723605,0))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c83723605.handcon)
	c:RegisterEffect(e2)
end
function c83723605.texfilter(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_LINK) and c:IsAttribute(ATTRIBUTE_WATER) and c:IsAbleToExtra()
		and Duel.IsExistingMatchingCard(c83723605.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c)
end
function c83723605.spfilter(c,e,tp,rc)
	return c:IsSetCard(0x12b) and c:IsType(TYPE_LINK) and c:IsLink(rc:GetLink()) and not c:IsCode(rc:GetCode())
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_LINK,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,rc,c)>0
end
function c83723605.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c83723605.texfilter(chkc,e,tp) end
	if chk==0 then return aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_LMATERIAL)
		and Duel.IsExistingTarget(c83723605.texfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c83723605.texfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c83723605.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_EXTRA)
		and aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_LMATERIAL) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c83723605.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc)
		local sc=g:GetFirst()
		if sc then
			sc:SetMaterial(nil)
			if Duel.SpecialSummon(sc,SUMMON_TYPE_LINK,tp,tp,false,false,POS_FACEUP)~=0 then
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
				e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
				e1:SetRange(LOCATION_MZONE)
				e1:SetValue(1)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
				sc:RegisterEffect(e1,true)
				local e2=Effect.CreateEffect(c)
				e2:SetType(EFFECT_TYPE_SINGLE)
				e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
				e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
				sc:RegisterEffect(e2,true)
				sc:CompleteProcedure()
			end
		end
	end
end
function c83723605.hcfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x12b) and c:IsLinkAbove(3)
end
function c83723605.handcon(e)
	return Duel.IsExistingMatchingCard(c83723605.hcfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
