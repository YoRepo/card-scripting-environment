--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 霸魔导士 奥金魔导师  (ID: 21113684)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 10
-- ATK 1400 | DEF 2800
-- Setcode: 110
--
-- Effect Text:
-- 魔法师族同调怪兽＋魔法师族怪兽
-- 这张卡用融合召唤才能从额外卡组特殊召唤。
-- ①：这张卡融合召唤成功的场合发动。给这张卡放置2个魔力指示物。
-- ②：这张卡的攻击力上升这张卡的魔力指示物数量×1000。
-- ③：1回合1次，可以把自己场上1个魔力指示物取除，从以下效果选择1个发动。
-- ●以场上1张卡为对象才能发动。那张卡破坏。
-- ●自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--覇魔導士アーカナイト・マジシャン
function c21113684.initial_effect(c)
	c:EnableCounterPermit(0x1)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c21113684.ffilter,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),true)
	--attackup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c21113684.attackup)
	c:RegisterEffect(e2)
	--fusion success
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(21113684,0))
	e3:SetCategory(CATEGORY_COUNTER)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c21113684.addcc)
	e3:SetTarget(c21113684.addct)
	e3:SetOperation(c21113684.addc)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(21113684,1))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e4:SetCost(c21113684.cost)
	e4:SetTarget(c21113684.destg)
	e4:SetOperation(c21113684.desop)
	c:RegisterEffect(e4)
	--draw
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(21113684,2))
	e5:SetCategory(CATEGORY_DRAW)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e5:SetCost(c21113684.cost)
	e5:SetTarget(c21113684.drtg)
	e5:SetOperation(c21113684.drop)
	c:RegisterEffect(e5)
	--spsummon condition
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetCode(EFFECT_SPSUMMON_CONDITION)
	e6:SetValue(c21113684.splimit)
	c:RegisterEffect(e6)
end
c21113684.material_type=TYPE_SYNCHRO
function c21113684.splimit(e,se,sp,st)
	if e:GetHandler():IsLocation(LOCATION_EXTRA) then
		return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
	end
	return true
end
function c21113684.ffilter(c)
	return c:IsFusionType(TYPE_SYNCHRO) and c:IsRace(RACE_SPELLCASTER)
end
function c21113684.attackup(e,c)
	return c:GetCounter(0x1)*1000
end
function c21113684.addcc(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c21113684.addct(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,2,0,0x1)
end
function c21113684.addc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x1,2)
	end
end
function c21113684.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanRemoveCounter(tp,1,0,0x1,1,REASON_COST) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.RemoveCounter(tp,1,0,0x1,1,REASON_COST)
end
function c21113684.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c21113684.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c21113684.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c21113684.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
