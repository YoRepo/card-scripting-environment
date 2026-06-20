--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 亚克力玩偶怪  (ID: 74879881)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：自己主要阶段才能发动。自己卡组最上面的卡翻开，那是怪兽的场合，那只怪兽特殊召唤，这张卡回到持有者卡组最下面。不是的场合或者不能特殊召唤的场合，那张卡回到卡组最下面。这个效果特殊召唤的怪兽在结束阶段
-- 回到持有者卡组最下面。
--[[ __CARD_HEADER_END__ ]]

--ミミックリル
function c74879881.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(74879881,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,74879881)
	e1:SetTarget(c74879881.sptg)
	e1:SetOperation(c74879881.spop)
	c:RegisterEffect(e1)
end
function c74879881.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and not Duel.IsPlayerAffectedByEffect(tp,63060238)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function c74879881.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.DisableShuffleCheck()
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
			local c=e:GetHandler()
			local fid=c:GetFieldID()
			tc:RegisterFlagEffect(74879881,RESET_EVENT+RESETS_STANDARD,0,1,fid)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetCountLimit(1)
			e1:SetLabel(fid)
			e1:SetLabelObject(tc)
			e1:SetCondition(c74879881.retcon)
			e1:SetOperation(c74879881.retop)
			Duel.RegisterEffect(e1,tp)
			if c:IsRelateToEffect(e) then
				Duel.SendtoDeck(c,nil,SEQ_DECKBOTTOM,REASON_EFFECT)
			end
		end
	else
		Duel.MoveSequence(tc,SEQ_DECKBOTTOM)
	end
end
function c74879881.retcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffectLabel(74879881)~=e:GetLabel() then
		e:Reset()
		return false
	else return true end
end
function c74879881.retop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.SendtoDeck(tc,nil,SEQ_DECKBOTTOM,REASON_EFFECT)
end
