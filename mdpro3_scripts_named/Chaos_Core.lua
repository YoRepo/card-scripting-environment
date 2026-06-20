--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 混沌核心  (ID: 54040484)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 0 | DEF 0
-- Setcode: 207
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡成为效果的对象时或者被选择作为对方怪兽的攻击对象时才能发动。「神炎皇 乌利亚」「降雷皇 哈蒙」「幻魔皇
-- 拉比艾尔」各最多1只从手卡·卡组送去墓地，送去墓地数量的幻魔指示物给这张卡放置，这个回合自己受到的战斗伤害变成0。
-- ②：这张卡被战斗·效果破坏的场合，可以作为代替把这张卡1个幻魔指示物取除。
--[[ __CARD_HEADER_END__ ]]

--カオス・コア
function c54040484.initial_effect(c)
	c:EnableCounterPermit(0x57)
	aux.AddCodeList(c,6007213,32491822,69890967)
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54040484,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_BECOME_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,54040484)
	e1:SetCondition(c54040484.countcon1)
	e1:SetTarget(c54040484.counttg)
	e1:SetOperation(c54040484.countop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetCondition(c54040484.countcon2)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c54040484.reptg)
	e3:SetOperation(c54040484.repop)
	c:RegisterEffect(e3)
end
function c54040484.countcon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsContains(e:GetHandler())
end
function c54040484.countcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and e:GetHandler()==Duel.GetAttackTarget()
end
function c54040484.tgfilter(c)
	return c:IsCode(6007213,32491822,69890967) and c:IsAbleToGrave()
end
function c54040484.counttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c54040484.tgfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil) and c:IsCanAddCounter(0x57,1) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c54040484.fselect(g,c)
	return aux.dncheck(g) and c:IsCanAddCounter(0x57,g:GetCount())
end
function c54040484.countop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c54040484.tgfilter,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:SelectSubGroup(tp,c54040484.fselect,false,1,g:GetCount(),c)
	if sg and sg:GetCount()>0 and Duel.SendtoGrave(sg,REASON_EFFECT)~=0 then
		if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
		local og=Duel.GetOperatedGroup()
		local ct=og:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)
		if ct>0 and c:AddCounter(0x57,ct) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e1:SetTargetRange(1,0)
			e1:SetValue(1)
			e1:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e1,tp)
		end
	end
end
function c54040484.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
		and c:IsCanRemoveCounter(tp,0x57,1,REASON_EFFECT)
	end
	return Duel.SelectEffectYesNo(tp,c,96)
end
function c54040484.repop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(tp,0x57,1,REASON_EFFECT)
end
