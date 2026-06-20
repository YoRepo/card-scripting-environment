--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 捕食生成  (ID: 72129804)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 243
--
-- Effect Text:
-- ①：把手卡的「捕食」卡任意数量给对方观看，以给人观看的数量的对方场上的表侧表示怪兽为对象才能发动。给那些怪兽各放置1个捕食指示物。有捕食指示物放置的2星以上的怪兽的等级变成1星。
-- ②：自己的「捕食植物」怪兽被战斗破坏的场合，可以作为代替把墓地的这张卡除外。
--[[ __CARD_HEADER_END__ ]]

--捕食生成
function c72129804.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c72129804.target)
	e1:SetOperation(c72129804.activate)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c72129804.reptg)
	e2:SetValue(c72129804.repval)
	e2:SetOperation(c72129804.repop)
	c:RegisterEffect(e2)
end
function c72129804.cfilter(c)
	return c:IsSetCard(0xf3) and not c:IsPublic()
end
function c72129804.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local hg=Duel.GetMatchingGroup(c72129804.cfilter,tp,LOCATION_HAND,0,e:GetHandler())
	local ct=Duel.GetTargetCount(Card.IsCanAddCounter,tp,0,LOCATION_MZONE,nil,0x1041,1)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsCanAddCounter(0x1041,1) end
	if chk==0 then return hg:GetCount()>0 and ct>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=hg:Select(tp,1,ct,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsCanAddCounter,tp,0,LOCATION_MZONE,g:GetCount(),g:GetCount(),nil,0x1041,1)
end
function c72129804.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local tc=tg:GetFirst()
	while tc do
		if tc:AddCounter(0x1041,1) and tc:IsLevelAbove(2) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetCondition(c72129804.lvcon)
			e1:SetValue(1)
			tc:RegisterEffect(e1)
		end
		tc=tg:GetNext()
	end
end
function c72129804.lvcon(e)
	return e:GetHandler():GetCounter(0x1041)>0
end
function c72129804.repfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x10f3) and c:IsLocation(LOCATION_MZONE)
		and c:IsControler(tp) and c:IsReason(REASON_BATTLE)
end
function c72129804.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c72129804.repfilter,1,nil,tp) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c72129804.repval(e,c)
	return c72129804.repfilter(c,e:GetHandlerPlayer())
end
function c72129804.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
