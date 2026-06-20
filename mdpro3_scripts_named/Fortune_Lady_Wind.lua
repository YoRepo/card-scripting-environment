--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 命运女郎·温蒂  (ID: 82693917)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Spellcaster
-- Level 3
-- ATK ? | DEF ?
-- Setcode: 49
--
-- Effect Text:
-- 这张卡的攻击力·守备力变成这张卡的等级×300的数值。自己的准备阶段时，这张卡的等级上升1星（等级最多12星）。这张卡召唤成功时，可以把自己场上表侧表示存在的名字带有「命运女郎」的怪兽数量的对方场上存
-- 在的魔法·陷阱卡破坏。
--[[ __CARD_HEADER_END__ ]]

--フォーチュンレディ・ウインディー
function c82693917.initial_effect(c)
	--atk,def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(c82693917.value)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_DEFENSE)
	c:RegisterEffect(e2)
	--level up
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(82693917,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCondition(c82693917.lvcon)
	e3:SetOperation(c82693917.lvop)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(82693917,1))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetTarget(c82693917.destg)
	e4:SetOperation(c82693917.desop)
	c:RegisterEffect(e4)
end
function c82693917.value(e,c)
	return c:GetLevel()*300
end
function c82693917.lvcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c82693917.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) or c:IsLevelAbove(12) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	c:RegisterEffect(e1)
end
function c82693917.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x31)
end
function c82693917.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c82693917.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local ct=Duel.GetMatchingGroupCount(c82693917.cfilter,tp,LOCATION_MZONE,0,nil)
		local dt=Duel.GetMatchingGroupCount(c82693917.filter,tp,0,LOCATION_ONFIELD,nil)
		e:SetLabel(ct)
		return dt>=ct
	end
	local g=Duel.GetMatchingGroup(c82693917.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,e:GetLabel(),0,0)
end
function c82693917.desop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c82693917.cfilter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(c82693917.filter,tp,0,LOCATION_ONFIELD,nil)
	if ct>g:GetCount() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local sg=g:Select(tp,ct,ct,nil)
	Duel.HintSelection(sg)
	Duel.Destroy(sg,REASON_EFFECT)
end
