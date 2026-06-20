--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 复仇死者的白昼黎明  (ID: 60375194)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 262
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：对方场上的卡数量比自己场上的卡多的场合才能发动。选自己场上1只仪式召唤的「复仇死者」怪兽，那只怪兽以外的场上的卡全部破坏。那只「复仇死者」怪兽只要在场上表侧表示存在不能直接攻击。
--[[ __CARD_HEADER_END__ ]]

--ヴェンデット・デイブレイク
function c60375194.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,60375194+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c60375194.condition)
	e1:SetTarget(c60375194.target)
	e1:SetOperation(c60375194.activate)
	c:RegisterEffect(e1)
end
function c60375194.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_ONFIELD)>Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)
end
function c60375194.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x106) and c:IsSummonType(SUMMON_TYPE_RITUAL)
end
function c60375194.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c60375194.filter,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount()-1,0,0)
end
function c60375194.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local tc=Duel.SelectMatchingCard(tp,c60375194.filter,tp,LOCATION_MZONE,0,1,1,nil):GetFirst()
	if not tc then return end
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,tc)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e1)
end
