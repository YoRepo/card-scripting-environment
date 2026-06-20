--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 卡通王国  (ID: 43175858)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 98
--
-- Effect Text:
-- ①：作为这张卡的发动时的效果处理，从自己卡组上面把3张卡里侧表示除外。
-- ②：这张卡只要在场地区域存在，卡名当作「卡通世界」使用。
-- ③：只要这张卡在场地区域存在，自己场上的卡通怪兽不会成为对方的效果的对象。
-- ④：自己场上的卡通怪兽被战斗·效果破坏的场合，可以作为代替把破坏的怪兽每1只1张卡从自己卡组上面里侧表示除外。
--[[ __CARD_HEADER_END__ ]]

--トゥーン・キングダム
function c43175858.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c43175858.target)
	e1:SetOperation(c43175858.activate)
	c:RegisterEffect(e1)
	--change code
	aux.EnableChangeCode(c,15259703,LOCATION_FZONE)
	--cannot be target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_TOON))
	e3:SetValue(aux.tgoval)
	c:RegisterEffect(e3)
	--destroy replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetTarget(c43175858.reptg)
	e4:SetValue(c43175858.repval)
	c:RegisterEffect(e4)
end
function c43175858.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetDecktopGroup(tp,3)
	if chk==0 then return g:FilterCount(Card.IsAbleToRemove,nil,tp,POS_FACEDOWN)==3 end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,3,tp,LOCATION_DECK)
end
function c43175858.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if ct==0 then return end
	if ct>3 then ct=3 end
	local g=Duel.GetDecktopGroup(tp,ct)
	Duel.DisableShuffleCheck()
	Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
end
function c43175858.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and c:IsType(TYPE_TOON) and c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
end
function c43175858.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=eg:FilterCount(c43175858.repfilter,nil,tp)
	local g=Duel.GetDecktopGroup(tp,ct)
	if chk==0 then return g:IsExists(Card.IsAbleToRemove,ct,nil,tp,POS_FACEDOWN) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		Duel.DisableShuffleCheck()
		Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
		return true
	else return false end
end
function c43175858.repval(e,c)
	return c43175858.repfilter(c,e:GetHandlerPlayer())
end
