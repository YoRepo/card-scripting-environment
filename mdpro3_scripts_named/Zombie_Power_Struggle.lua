--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 不死斗争  (ID: 65357623)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：以场上1只不死族怪兽为对象才能发动。直到回合结束时，那只怪兽的攻击力上升1000或者下降1000。
-- ②：这张卡在墓地存在的场合，自己主要阶段才能发动。选除外的1只自己的不死族怪兽回到卡组，这张卡在自己场上盖放。这个效果盖放的这张卡从场上离开的场合除外。
--[[ __CARD_HEADER_END__ ]]

--アンデット・ストラグル
function c65357623.initial_effect(c)
	--modify ATK
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetDescription(aux.Stringid(65357623,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(aux.dscon)
	e1:SetTarget(c65357623.target)
	e1:SetOperation(c65357623.activate)
	c:RegisterEffect(e1)
	--Shuffle to set from GY
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_SSET)
	e2:SetDescription(aux.Stringid(65357623,3))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,65357623)
	e2:SetTarget(c65357623.settg)
	e2:SetOperation(c65357623.setop)
	c:RegisterEffect(e2)
end
function c65357623.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE)
end
function c65357623.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc,race)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c65357623.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c65357623.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c65357623.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c65357623.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local atk=1000
		if Duel.SelectOption(tp,aux.Stringid(65357623,1),aux.Stringid(65357623,2))==1 then atk=-1000 end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(atk)
		tc:RegisterEffect(e1)
	end
end
function c65357623.retfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE) and c:IsAbleToDeck()
end
function c65357623.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsSSetable()
		and Duel.IsExistingMatchingCard(c65357623.retfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,e:GetHandler(),1,0,0)
end
function c65357623.setop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c65357623.retfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	if #g>0 then
		Duel.HintSelection(g)
		if Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)>0 and c:IsRelateToEffect(e) and Duel.SSet(tp,c)~=0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
			e1:SetValue(LOCATION_REMOVED)
			c:RegisterEffect(e1)
		end
	end
end
