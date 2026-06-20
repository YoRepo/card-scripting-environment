--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 魔界剧团的谢幕  (ID: 4682617)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 4332
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：「魔界台本」魔法卡的效果发动的回合才能发动。把最多有自己墓地的「魔界台本」魔法卡数量的表侧表示的「魔界剧团」灵摆怪兽从自己的额外卡组加入手卡。那之后，可以把最多有这个效果加入手卡的怪兽数量的「魔界
-- 剧团」灵摆怪兽从手卡特殊召唤（同名卡最多1张）。这张卡的发动后，直到回合结束时自己不是「魔界剧团」灵摆怪兽不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--魔界劇団のカーテンコール
function c4682617.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,4682617+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c4682617.condition)
	e1:SetTarget(c4682617.target)
	e1:SetOperation(c4682617.activate)
	c:RegisterEffect(e1)
	--activity check
	Duel.AddCustomActivityCounter(4682617,ACTIVITY_CHAIN,c4682617.chainfilter)
end
function c4682617.chainfilter(re,tp,cid)
	return not (re:IsActiveType(TYPE_SPELL) and re:GetHandler():IsSetCard(0x20ec))
end
function c4682617.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCustomActivityCount(4682617,tp,ACTIVITY_CHAIN)>0
end
function c4682617.thfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x10ec) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c4682617.spfilter(c,e,tp)
	return c:IsSetCard(0x10ec) and c:IsType(TYPE_PENDULUM) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c4682617.ctfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsSetCard(0x20ec)
end
function c4682617.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c4682617.ctfilter,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingMatchingCard(c4682617.thfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c4682617.activate(e,tp,eg,ep,ev,re,r,rp)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,0)
		e1:SetTarget(c4682617.splimit)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
	local ct=Duel.GetMatchingGroupCount(c4682617.ctfilter,tp,LOCATION_GRAVE,0,nil)
	if ct<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local hg=Duel.SelectMatchingCard(tp,c4682617.thfilter,tp,LOCATION_EXTRA,0,1,ct,nil)
	if hg:GetCount()>0 and Duel.SendtoHand(hg,nil,REASON_EFFECT)~=0 then
		local sct=Duel.GetOperatedGroup():FilterCount(Card.IsControler,nil,tp)
		local sg=Duel.GetMatchingGroup(c4682617.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
		local ft=math.min((Duel.GetLocationCount(tp,LOCATION_MZONE)),sg:GetClassCount(Card.GetCode))
		if sct>0 and ft>0 and Duel.SelectYesNo(tp,aux.Stringid(4682617,0)) then
			Duel.BreakEffect()
			if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=sg:SelectSubGroup(tp,aux.dncheck,false,1,math.min(ft,sct))
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
function c4682617.splimit(e,c)
	return not (c:IsSetCard(0x10ec) and c:IsType(TYPE_PENDULUM))
end
