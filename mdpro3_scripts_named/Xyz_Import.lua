--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 超量输入  (ID: 14602126)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 115
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以自己场上1只超量怪兽和持有那个攻击力以下的攻击力的对方场上1只怪兽为对象才能发动。那只对方怪兽在那只自己怪兽下面重叠作为超量素材。
--[[ __CARD_HEADER_END__ ]]

--エクシーズ・インポート
function c14602126.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,14602126+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c14602126.target)
	e1:SetOperation(c14602126.activate)
	c:RegisterEffect(e1)
end
function c14602126.xyzfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
		and Duel.IsExistingTarget(c14602126.matfilter,tp,0,LOCATION_MZONE,1,nil,c:GetAttack())
end
function c14602126.matfilter(c,atk)
	return c:IsFaceup() and c:IsAttackBelow(atk) and c:IsCanOverlay()
end
function c14602126.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c14602126.xyzfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c14602126.xyzfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c14602126.matfilter,tp,0,LOCATION_MZONE,1,1,nil,tc:GetAttack())
end
function c14602126.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local lc=tg:GetFirst()
	if lc==tc then lc=tg:GetNext() end
	if tc:IsRelateToEffect(e) and tc:IsControler(tp) and not tc:IsImmuneToEffect(e) and lc:IsRelateToEffect(e) and lc:IsControler(1-tp) and lc:IsType(TYPE_MONSTER) and not lc:IsImmuneToEffect(e) then
		local og=lc:GetOverlayGroup()
		if og:GetCount()>0 then
			Duel.SendtoGrave(og,REASON_RULE)
		end
		Duel.Overlay(tc,Group.FromCards(lc))
	end
end
