--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 超量双璧同归  (ID: 57836546)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 115
--
-- Effect Text:
-- 自己场上的超量怪兽被破坏的回合，自己场上没有怪兽存在的场合才能发动。从自己墓地选择1只那个回合被破坏的超量怪兽和1只那只怪兽的攻击力以下的怪兽特殊召唤。这个效果特殊召唤的怪兽在结束阶段时破坏。
--[[ __CARD_HEADER_END__ ]]

--エクシーズ・ダブル・バック
function c57836546.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c57836546.condition)
	e1:SetTarget(c57836546.target)
	e1:SetOperation(c57836546.activate)
	c:RegisterEffect(e1)
end
function c57836546.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c57836546.filter1(c,e,tp,turn)
	return c:IsType(TYPE_XYZ) and c:IsReason(REASON_DESTROY) and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsPreviousPosition(POS_FACEUP) and c:GetTurnID()==turn and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingTarget(c57836546.filter2,tp,LOCATION_GRAVE,0,1,c,e,tp,c:GetAttack())
end
function c57836546.filter2(c,e,tp,atk)
	return c:IsAttackBelow(atk) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c57836546.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingTarget(c57836546.filter1,tp,LOCATION_GRAVE,0,1,nil,e,tp,Duel.GetTurnCount()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c57836546.filter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,Duel.GetTurnCount())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c57836546.filter2,tp,LOCATION_GRAVE,0,1,1,g1:GetFirst(),e,tp,g1:GetFirst():GetAttack())
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,2,0,0)
end
function c57836546.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()~=2 or Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	local fid=e:GetHandler():GetFieldID()
	local tc=g:GetFirst()
	while tc do
		if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
			tc:RegisterFlagEffect(57836546,RESET_EVENT+RESETS_STANDARD,0,1,fid)
		end
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
	g:KeepAlive()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCountLimit(1)
	e1:SetCondition(c57836546.descon)
	e1:SetOperation(c57836546.desop)
	e1:SetLabel(fid)
	e1:SetLabelObject(g)
	Duel.RegisterEffect(e1,tp)
end
function c57836546.desfilter(c,fid)
	return c:GetFlagEffectLabel(57836546)==fid
end
function c57836546.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c57836546.desfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c57836546.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=e:GetLabelObject()
	local dg=sg:Filter(c57836546.desfilter,nil,e:GetLabel())
	if dg:GetCount()>0 then
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
